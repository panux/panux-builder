package main

import (
	"os"

	"github.com/panux/package-builder"
)

func main() {
	rpg, err := panuxpackager.ParseFile(os.Args[0])
	if err != nil {
		panic(err)
	}
	pg, err := rpg.Preprocess()
	if err != nil {
		panic(err)
	}
	f, err := os.OpenFile(os.Args[1], os.O_CREATE|os.O_WRONLY, 0700)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	err = pg.GenPkgSrc(f)
	if err != nil {
		panic(err)
	}
}
