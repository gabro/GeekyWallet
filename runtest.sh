#! /bin/sh

pegjs --track-line-and-column parser.pegjs
node test.js