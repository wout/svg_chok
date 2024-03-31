# SVGchock

A micro app written in Crystal to visualise Sverchok SVG output.

## Installation

1. Install Crystal: https://crystal-lang.org/install/
2. Clone the repo: `git clone https://github.com/wout/svg_chock`
3. Cd into the repo: `cd svg_chock`
4. Run the app: `shards run`

**Note**: On the first run, the app will install the required dependencies.

## Usage

When the app is booted, the `svgs` directory is created (configurable in `config.yml`). Make sure Sverchok is writing it's SVG output to that dir. It can either be directly into it or in a sub-directory if you prefer to organise your files.

The app will serve the SVGs on `http://0.0.0.0:4141`. Any changes to files in the `svgs` directory will immediately be reflected on the frontend of this app.

## Why this app?

By default, Sverchok creates a HTML file which you can load into your browser. This file has some embedded JavaScript to reload the SVG file using a configurable interval (every 250ms by default). Two things are unfortunate with this setup:

1. There's a lot of unnecessary rendering of the SVG file, which may be an issue with complex scenes.
2. Since it's a file loaded into your browser, the output can't run through a HTTP tunnel (e.g. NGrok) to easily display the output on other devices.

While both arguments are not necessarily applicable to all use cases, another benefit is a nicer layout and a browsable index of all SVGs, with previews. So either way, it's always a better experience than using the default HTML file.

## Contributing

1. Fork it (<https://github.com/wout/svg_chock/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'feat: add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Wout](https://github.com/wout) - creator and maintainer
