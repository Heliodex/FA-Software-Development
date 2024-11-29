package main

import (
	"fmt"
	"html/template"
	"io"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

type Data struct {
	Path, Title, Template string
}

var pages = []Data{
	{"/", "Home", "pages/index.html"},
	{"/contact", "Contact", "pages/contact.html"},
	{"/visit", "Visit", "pages/visit/index.html"},
	{"/visit/walks", "Walks", "pages/visit/walks.html"},
	{"/visit/café", "Café", "pages/visit/café.html"},
	{"/visit/pettingzoo", "Petting zoo", "pages/visit/pettingzoo.html"},
	{"/gallery", "Gallery", "pages/gallery.html"},
}

type Renderer struct{}

var pageData = map[string]map[string]any{
	"pages/gallery.html": {
		"Images": []int{1, 2, 3, 4, 5},
	},
	"pages/visit/café.html": {
		"Menu": [][2]any{
			{"Meals", [][3]string{
				{"Soup of the day, with fresh sourdough", "", "£5.50"},
				{"Full breakfast (tattie scones not forgotten!)", "", "£8.00"},
				{"Toasted filled paninis", "V/VV available", "£6.00"},
				{"Ham and cheese sandwich with salad", "", "£3.20"},
				{"Vegetable chilli beans with rice", "VV", "£5.80"},
			}},
			{"Sides", [][3]string{
				{"Roasted tatties with garlic and rosemary", "VV", "£2.50"},
				{"Side salad", "VV", "£2.00"},
				{"Chunky chips with dipping sauces", "VV", "£2.00"},
			}},
			{"Drinks", [][3]string{
				{"Coffee, black/white", "V/VV", "£2.00"},
				{"Decaf coffee, black/white", "V/VV", "£2.00"},
				{"Tea", "V/VV", "£2.00"},
				{"Decaf tea", "V/VV", "£2.00"},
				{"Fresh-pressed orange juice", "VV", "£1.50"},
				{"Fresh-pressed apple & blackcurrant juice", "VV", "£1.50"},
			}},
		},
	},
	"pages/visit/pettingzoo.html": {
		"Animals": [][2]any{
			{"Bella", "Bella is our resident majestic Highland cow. They are very friendly, curious, and loves strokes!"},
			{"Hens", "We have five hens, two of which (Natasha and Jenny) are very friendly and curious. The others are a little more feisty."},
		},
	},
}

var layout = template.Must(template.ParseFiles("layout.html"))

func (r Renderer) Render(w io.Writer, name string, data any, c echo.Context) (err error) {
	t := template.Must(template.ParseFiles(name))

	b := &strings.Builder{}
	if err = t.ExecuteTemplate(b, t.Name(), pageData[name]); err != nil {
		return
	} else if err = layout.ExecuteTemplate(w, "layout.html", echo.Map{
		"Data": data,
		"Body": template.HTML(b.String()),
	}); err != nil {
		fmt.Println(err)
		return
	}

	return
}

func main() {
	e := echo.New()
	e.Logger.SetOutput(io.Discard)
	e.Static("/", "static")

	// custom echo renderer
	e.Renderer = Renderer{}

	for _, v := range pages {
		e.GET(v.Path, func(c echo.Context) (err error) {
			if err = c.Render(http.StatusOK, v.Template, v); err != nil {
				fmt.Println(err)
			}
			return err
		})
	}

	fmt.Println("Listening on :8090")
	panic(e.Start(":8090"))
}
