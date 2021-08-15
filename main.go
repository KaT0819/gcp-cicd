package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	port := "8080"
	if fromEnv := os.Getenv("PORT"); fromEnv != "" {
		port = fromEnv
	}
	server := http.NewServeMux()
	server.HandleFunc("/", hello)
	log.Printf("Server Listening on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, server))
}

func hello(w http.ResponseWriter, r *http.Request) {
	log.Printf("Serving Request: %s", r.URL.Path)
	host, _ := os.Hostname()
	fmt.Fprintf(w, "Hello, World!\n")
	fmt.Fprintf(w, "Version: World!\n")
	fmt.Fprintf(w, "Hostname: %s\n", host)
}
