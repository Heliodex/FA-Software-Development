package main

import (
	"errors"
	"html/template"
	"io"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Templates map[string]*template.Template

type Data struct {
	Path  string
	Title string
}

func (t Templates) Render(w io.Writer, name string, data any, c echo.Context) error {
	tmpl, ok := t[name]
	if !ok {
		return errors.New("Template " + name + " not found")
	}
	return tmpl.ExecuteTemplate(w, "layout.html", data)
}

var pages = []Data{
	{Path: "", Title: "Home"},
	{Path: "page2", Title: "Page 2"},
}

func main() {
	e := echo.New()
	e.Logger.SetOutput(io.Discard)
	e.Static("/", "static")

	// turn the templates into a map
	templates := make(Templates)
	for _, v := range template.Must(template.ParseGlob("pages/*.html")).Templates() {
		templates[v.Name()] = v
	}
	e.Renderer = templates

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
