package main

import (
	"embed"
	"fmt"
	"html/template"
	"net/http"
	"strings"
)

//go:embed *.html
var files embed.FS

var (
	layoutT = template.Must(template.ParseFS(files, "layout.html"))
	indexT  = template.Must(template.ParseFS(files, "index.html"))
)

func toString(t *template.Template) (string, error) {
	i := strings.Builder{}
	err := t.Execute(&i, nil)
	return i.String(), err
}

func handler(w http.ResponseWriter, r *http.Request) {
	i, err := toString(indexT)
	if err != nil {
		panic(err)
	}

	err = layoutT.Execute(w, template.HTML(i))
	if err != nil {
		panic(err)
	}
}

func main() {
	http.HandleFunc("/", handler)

	fmt.Println("Listening on port 8080")
	http.ListenAndServe(":8080", nil)
}
