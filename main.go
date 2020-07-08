package main

import (
	"context"

	"github.com/x-mod/build"
	"github.com/x-mod/cmd"
	"github.com/x-mod/routine"
)

func main() {
	cmd.Version(build.String())
	cmd.Add(
		cmd.Name("action"),
		cmd.Main(Main),
	)
	cmd.Execute()
}

func Main(c *cmd.Command, args []string) error {
	return routine.Main(
		context.TODO(),
		routine.Command("echo", routine.ARG("hello github action!")),
	)
}
