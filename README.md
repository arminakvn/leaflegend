# leaflegend

interactive legend for leafletjs supporting bivariate choropleth maps

## About

A JavaScript library by **_320ryder_**.

See the [demo](http://arminakvn.github.io/leaflegend/demo/index.html).

## setting up for development

We are using [Yeoman](http://yeoman.io/) for generating library, [GRUNT](http://gruntjs.com) for tasks and [Bower](http://bower.io/) for packaging.

You could use [Homebrew](http://brew.sh) to install npm.

make sure you have installed npm. If using *NIX machines you can use [Homebrew](http://brew.sh):
```
brew install npm
```
install yo with:
```
npm install -g yo
```
install bower with:
```
npm install -g bower
```

install the yo's library generator with:
```
npm install -g generator-lib
```
you can use `npm` to install [GRUNT](http://gruntjs.com/getting-started):
```
npm install -g grunt-cli
```
if the grunt plugins are not installed you can run `npm install` when cd'd in the project directory.

Fork the reposotiry then clone your fork of the repository from GitHub and cd into it.
run the grunt tasks with:
```
grunt
```
for just compiling coffee to js run:
```
grunt coffee
```
for watching the coffee files for automatic compiling use:
```
grunt watch
```


## Documentation

Start with `docs/MAIN.md`.

## Contributing

We'll check out your contribution if you:

* Provide a comprehensive suite of tests for your fork.
* Have a clear and documented rationale for your changes.
* Package these up in a pull request.

We'll do our best to help you out with any contribution issues you may have.

## License

MIT. See `LICENSE.txt` in this directory.
