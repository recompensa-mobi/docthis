# DocThis!

**DocThis!** is a very small mountable engine we use in our rails applications
to render any markdown files stored in a documentation folder inside the
application. The markdown files are parsed and rendered in a wiki-style format,
which allows us to access and navigate the documentation easily.

## Why?

Documentation is an integral part of our products. While we strive to have
self-documenting code and executable specs, not all documentation can be
defined with those two techniques. And not all documentation is meant to be
read by technical people.

At Recompensa.mobi, our documentation is treated in the same way we treat our
source code. There is a folder in the application repository where all
documentation files are created, using markdown, a pure-text format, and
merged, tagged and deployed with the rest of the source code of the
application.

One problem we faced though is that while markdown is great to write, wading
through files in the documentation folder is not a great way to read.
Navegability and readability are not great, and there is no way other that
cloning the repo to access the documentation.

**DocThis!** exposes the documentation folder in the repository as a mountable
rails engine. No more navigating through files, **DocThis!** creates a wiki you
can host anywhere in your rails application by reading your markdown files in
the documentation folder and rendering them.

## Usage

### Installation

Add the gem to your Gemfile:

~~~ruby
gem "docthis"
~~~

Run bundle to install the engine:

~~~
> bundle install
~~~

Mount your engine wherever you like by adding the following line to your
application routes:

~~~ruby
mount Docthis::Engine, at: "internal/docs"
~~~

Done! Start your application and navigate to `localhost:3000/internal/docs` to
see your documentation index. Any file in your `docs` folder can be accessed by
prefixing this path.

### Configuration

You can use an initializer to configure the behaviour of the engine:

~~~ruby
Docthis.configure do |config|
  # Use basic auth to protect any requests to the docs site. Defaults to false.
  config.use_basic_auth = true
  config.basic_auth_username = "internal"
  config.basic_auth_password = "password"

  # Name of the folder containing the documentation. Defaults to docs.
  config.docs_folder = "docs"

  # Name of the stylesheet to apply. Can be any of the following bootswatch
  # themes: amelia, cerulean, cosmo, cyborg, darkly, flatly, journal, lumen,
  # readable, simplex, slate, spacelab, superhero, united, yeti
  config.theme = :darkly
end
~~~

### Writing documentation

You can create markdown files and folders containing markdown files (up to one
level deep) in the documentation folder. Any file named `index.md` will be
rendered if the folder is requested. For example, you could have something like
this:

~~~
docs/
  features/
    index.md
    first-feature.md
  index.md
  glossary.md
~~~

Given that directory structure, and assuming you mount the engine at
`internal/docs`, you'll get these urls:

* `/internal/docs`: The engine root will render the `docs/index.md` file.

* `/internal/docs/glossary`: Will render the `docs/glossary.md` file.

* `/internal/docs/features`: Will render the `docs/features/index.md` file.

* `/internal/docs/features/first-feature`: Will render the
  `docs/features/first-feature.md` file.

In addition to this, the engine will process the folder structure and create
items in the navigation bar to access these files.

## License

Copyright (C) 2014 Recompensa.mobi


Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

