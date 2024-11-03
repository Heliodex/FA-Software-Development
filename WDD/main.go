package main

import (
	"errors"
	"fmt"
	"html/template"
	"io"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Templates map[string]*template.Template

type Data struct {
	Title string
}

func (t Templates) Render(w io.Writer, name string, data any, c echo.Context) error {
	tmpl, ok := t[name]
	if !ok {
		return errors.New("Template " + name + " not found")
	}
	return tmpl.ExecuteTemplate(w, "layout.html", data)
}

func main() {
	e := echo.New()
	e.Static("/static", "static")

	// turn the templates into a map
	templates := make(Templates)
	for _, v := range template.Must(template.ParseGlob("pages/*.html")).Templates() {
		templates[v.Name()] = v
	}
	e.Renderer = templates

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
