
# Language MJML

Adds syntax highlighting and snippets to MJML files in Atom.

This is a fork from `language-html` by atom.

## Installation

```sh
apm install language-mjml
```

## Usage

### Template

Type `mjml-` and hit <kbd>tab</kbd> to see the magic happen

```html
<!-- will expand to -->
<mjml>
  <mj-head>
    <mj-title></mj-title>
    <mj-attributes>

    </mj-attributes>
  </mj-head>
  <mj-body>
      <mj-section>
        <mj-column>

        </mj-column>
      </mj-section>
  </mj-body>
</mjml>
```

### Components

Type any `mjml` tag name, without `mj-` and hit <kbd>tab</kbd> to see the magic happen. Ex: `body`

```html
<!-- will expand to -->
<mj-body>

</mj-body>
```

## Contributing

Contributions are greatly appreciated. Please fork this repository and open a
pull request to add snippets, make grammar tweaks, etc.
