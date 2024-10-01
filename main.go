// httpserve/main.go (C) Red Hat 2024
// License: MIT

package main

import (
	"log"
	"net/http"
	"strconv"

	flag "github.com/spf13/pflag"
)

func main() {
	var bindAddr string = "0.0.0.0"
	var serveDir string = "."
	var port string = "8000"
	flag.StringVarP(&bindAddr, "bind", "b", bindAddr, "bind to this address")
	flag.StringVarP(&serveDir, "directory", "d", serveDir, "serve this directory")
	flag.Parse()

	if args := flag.Args(); len(args) > 0 {
		if len(args) > 1 {
			log.Fatalf("unrecognized arguments: %v", args[1:])
		}
		port = args[0]
	}

	if _, err := strconv.Atoi(port); err != nil {
		log.Fatalf("argument port: invalid int value: %q", port)
	}

	log.Printf("Serving HTTP on %s port %s ...\n", bindAddr, port)
	h := http.FileServer(http.Dir(serveDir))
	http.ListenAndServe(bindAddr+":"+port, h)
}
