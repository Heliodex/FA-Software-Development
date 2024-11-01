package main

import (
	"embed"
	"fmt"
	"html/template"
	"net/http"
	"strings"
)

var (
	//go:embed layout.html
	layout string
	//go:embed index.html
	pages embed.FS
	//go:embed static/*
	static embed.FS
)

var layoutT = template.Must(template.New("layout").Parse(layout))

func toString(t *template.Template) template.HTML {
	i := strings.Builder{}
	t.Execute(&i, nil)
	return template.HTML(i.String())
}

var pathFiles = map[string]string{
	"/": "index.html",
}

func handler(w http.ResponseWriter, r *http.Request) {
	filename, ok := pathFiles[r.URL.Path]
	if !ok {
		http.Error(w, "Not Found: "+r.URL.Path, http.StatusNotFound)
		return
	}

	file, _ := template.ParseFS(pages, filename)

	err := layoutT.Execute(w, toString(file))
	if err != nil {
		panic(err)
	}
}

func main() {
	http.HandleFunc("/", handler)
	http.Handle("/static/", http.FileServer(http.FS(static)))

	fmt.Println("Listening on port 8080")
	http.ListenAndServe(":8080", nil)
}
