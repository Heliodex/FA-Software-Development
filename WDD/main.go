package main

import (
	"errors"
	"fmt"
	"html/template"
	"io"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Template struct {
	tmpl map[string]*template.Template
}

type Data struct {
	Title string
}

func (t *Template) Render(w io.Writer, name string, data any, c echo.Context) error {
	tmpl, ok := t.tmpl[name]
	if !ok {
		err := errors.New("Template not found -> " + name)
		return err
	}
	return tmpl.ExecuteTemplate(w, "layout", data)
}

var pages = []string{"index.html"}

var e = echo.New()

func main() {
	e.Static("/static", "static")

	templates := make(map[string]*template.Template)
	for _, v := range pages {
		templates[v] = template.Must(template.ParseFiles("pages/"+v, "layout.html"))
	}

	e.Renderer = &Template{templates}

	e.GET("/", func(c echo.Context) (err error) {
		err = c.Render(http.StatusOK, "index.html", Data{
			Title: "Hello World",
		})
		if err != nil {
			fmt.Println(err)
		}
		return
	})

	panic(e.Start(":8080"))
}
