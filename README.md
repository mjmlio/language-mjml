
# Language MJML

Adds syntax highlighting and snippets to MJML files in Atom.

This is a fork from language-html by atom

## Installation

```
apm install language-mjml
```

## Usage

Template

Type `mjml-` and hit <Tab> to see the magic happen

```
mjml-<tab>

# will expand to

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

Components

type any mjml tag name, without `mj-` and hit <Tab> to see the magic happen

```
body<tab>

# will expand to

<mj-body>

</mj-body>

```

Contributions are greatly appreciated. Please fork this repository and open a
pull request to add snippets, make grammar tweaks, etc.
