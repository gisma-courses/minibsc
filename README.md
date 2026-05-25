# MiniBSc GIS

Static archive of a German-language introductory GIS course for Bachelor-level geography teaching.

The repository contains exported eLearning material, not a modern source-based build project. The course is delivered as static HTML with accompanying images, text files, multimedia assets, stylesheets, JavaScript and legacy eLearning support files. It can be browsed directly through GitHub Pages or served locally as a static website.

## Online course

Main entry point:

<https://gisma-courses.github.io/minibsc/GISBScL1/de/html/index.html>

Direct module entry points:

1. <https://gisma-courses.github.io/minibsc/GISBScL1/de/html/index.html>  
   GIS as spatial thinking in geography
2. <https://gisma-courses.github.io/minibsc/GISBScL2/de/html/index.html>  
   Relations and databases as foundations of spatial information systems
3. <https://gisma-courses.github.io/minibsc/GISBScL3/de/html/index.html>  
   Spatial analysis methods
4. <https://gisma-courses.github.io/minibsc/GISBScL4/de/html/index.html>  
   Spatial decision making
5. <https://gisma-courses.github.io/minibsc/GISBScL5/de/html/index.html>  
   Project work

## Course focus

The material introduces GIS as a way of structuring, analysing and interpreting spatial information. It combines conceptual material, practical GIS examples, knowledge checks, glossaries, bibliographies and project-oriented learning units.

The main thematic blocks are:

- spatial thinking, geographic information and spatial reference systems
- data management, relational databases, attributes and geometries
- spatial queries and GIS-based information extraction
- spatial analysis methods, including interpolation and terrain-derived information
- multi-criteria spatial decision support
- planning and carrying out a GIS project

The course was originally designed for self-directed learning in a university geography context. It is useful as an archive, as teaching reference material, or as a source base for modernizing an introductory GIS course.

## Repository structure

```text
.
├── GISBScL1/de/        # module 1: GIS, spatial thinking, spatial reference
├── GISBScL2/de/        # module 2: relations, databases, data management
├── GISBScL3/de/        # module 3: spatial analysis methods
├── GISBScL4/de/        # module 4: spatial decision making
├── GISBScL5/de/        # module 5: project work
├── _templates/         # legacy template material
├── core/               # shared technical course assets
├── daten/              # data files used by the course
├── material/           # additional course material
├── test/               # test or support material
├── cgi-bin/            # legacy server-side/test material
├── .nojekyll           # GitHub Pages: serve files as-is
└── README.md
```

The module folders usually contain subfolders such as:

```text
html/        # generated course pages
image/       # images used in the module
text/        # source or exported text material
material/    # additional data or exercise material, where present
multimedia/  # media assets, where present
```

## Local use

No installation or build step is required for the exported course pages.

Clone the repository:

```bash
git clone https://github.com/gisma-courses/minibsc.git
cd minibsc
```

Serve the folder locally:

```bash
python3 -m http.server 8000
```

Then open:

```text
http://localhost:8000/GISBScL1/de/html/index.html
```

Opening the HTML files directly in a browser may work, but a local web server is safer because relative links and browser security rules can otherwise behave differently.

## Maintenance notes

This repository should be treated as a static course archive.

There is currently no documented build pipeline, dependency management or authoring workflow in the repository. The root `index.html` is not the course landing page; it appears to be a legacy/default hosting page. Use the `GISBScL*/de/html/index.html` files as module entry points instead.

For active reuse in current teaching, the material should be reviewed and modernized. In particular, software screenshots, GIS workflows, links, exercises and external references may be outdated. A likely modernization route would be to extract the relevant conceptual and practical material and migrate it into a current course system such as Quarto or another static-site workflow.

## Reuse and licensing

The exported course pages display a `CC by-nc-sa` notice in their footer. No separate `LICENSE` file is included in the repository. Before republication or substantial reuse, check the rights situation for the course text, embedded images and third-party media.

## Suggested citation

```text
GISMA Courses. MiniBSc GIS. GitHub repository:
https://github.com/gisma-courses/minibsc
```
