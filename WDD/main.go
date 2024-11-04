package main

import (
	"fmt"
	"html/template"
	"io"
	"net/http"
	"strings"

	"github.com/labstack/echo/v4"
)

type Templates struct{ *template.Template }

var layout = template.Must(template.ParseFiles("layout.html"))

func (t Templates) Render(w io.Writer, name string, data any, c echo.Context) error {
	b := &strings.Builder{}
	if err := t.ExecuteTemplate(b, name, data); err != nil {
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

type Data struct {
	Path  string
	Title string
}

var pages = []Data{
	{"", "Home"},
	{"page2", "Page 2"},
}

func main() {
	e := echo.New()
	e.Logger.SetOutput(io.Discard)
	e.Static("/", "static")

	// turn the templates into a map
	e.Renderer = Templates{template.Must(template.ParseGlob("pages/*.html"))}

	for _, v := range pages {
		pageName := v.Path
		if pageName == "" {
			pageName = "index"
		}

		e.GET("/"+v.Path, func(c echo.Context) error {
			return c.Render(http.StatusOK, pageName+".html", v)
		})
	}

	panic(e.Start(":8080"))
}
