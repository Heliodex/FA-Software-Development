package main

import (
	"fmt"
	"html/template"
	"io"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

var layout = template.Must(template.ParseFiles("layout.html"))

type Data struct {
	Path, Title, Template string
}

var pages = []Data{
	{"/", "Home", "pages/index.html"},
	{"/contact", "Contact", "pages/contact.html"},
	{"/visit", "Visit", "pages/visit/index.html"},
	{"/visit/walks", "Walks", "pages/visit/walks.html"},
	{"/gallery", "Gallery", "pages/gallery.html"},
}

type Renderer struct{}

func (r Renderer) Render(w io.Writer, name string, data any, c echo.Context) error {
	t := template.Must(template.ParseFiles(name))

	b := &strings.Builder{}
	if err := t.ExecuteTemplate(b, t.Name(), data); err != nil {
		return err
	}

	if err := layout.ExecuteTemplate(w, "layout.html", echo.Map{
		"Data": data,
		"Body": template.HTML(b.String()),
	}); err != nil {
		fmt.Println(err)
		return err
	}

	return nil
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

	fmt.Println("Listening on :8080")
	panic(e.Start(":8080"))
}
