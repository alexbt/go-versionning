package server

import (
	"net/http"
	"fmt"
	"log"
	"github.com/gorilla/mux"
	"io"
	"github.com/alexbt/go-versionning/pkg/public/version"
)

var contextRoot = "/example"

func StartServer() {
	router := mux.NewRouter()
	router.HandleFunc(contextRoot, HandleRequests).Methods(http.MethodGet)
	println("3......")
	httpServer := http.ListenAndServe(fmt.Sprintf(":%s", "8081"), router)
	println("Listening...")
	log.Fatal(httpServer)
}

func HandleRequests(writer http.ResponseWriter, reader *http.Request) {
	println("handleRequest...")

	io.WriteString(writer,
		fmt.Sprintf("Hello World\nversion:%s\ngit commit:%s\ngit branch:%s\ntimestamp:%s",
			version.VERSION,
			version.GIT_HASH,
			version.GIT_BRANCH,
			version.TIMESTAMP))
}
