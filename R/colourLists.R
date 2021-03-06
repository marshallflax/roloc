
## A colourList has to be a list with components 'names' and 'colours'
## The latter should be a "color" object (from the 'colorspace' package)
## with the same number of colours as length(names)

colourList <- function(names, colours) {
    if (!is(colours, "color"))
        stop("'colours' must be a color object")
    if (nrow(coords(colours)) != length(names))
        stop("'colours' and 'names' not the same length")
    cl <- list(names=as.character(names), colours=colours)
    class(cl) <- "colourList"
    cl
}

colorList <- colourList

## Predefined colourLists

## The list of colours that R knows about
Rcolours <- colourList(names=colours(),
                       colours=sRGB(t(col2rgb(colours())/255)))
## Aliases
X11colours <- Rcolours
SVGcolours <- Rcolours
CSScolours <- Rcolours
Rcolors <- Rcolours
X11colors <- Rcolours
SVGcolors <- Rcolours
CSScolors <- Rcolours

## A small standard set for the Web ("HTML colours")
HTMLcolours <- colourList(names=c("black",
                                  "silver",
                                  "gray",
                                  "white",
                                  "maroon",
                                  "red",
                                  "purple",
                                  "fuschia",
                                  "green",
                                  "lime",
                                  "olive",
                                  "yellow",
                                  "navy",
                                  "blue",
                                  "teal",
                                  "aqua"),
                          colours=sRGB(rbind(c(0,0,0),
                                             c(192, 192, 192),
                                             c(128, 128, 128),
                                             c(255, 255, 255),
                                             c(128, 0, 0),
                                             c(255, 0, 0),
                                             c(128, 0, 128),
                                             c(255, 0, 255),
                                             c(0, 128, 0),
                                             c(0, 255, 0),
                                             c(128, 128, 0),
                                             c(255, 255, 0),
                                             c(0, 0, 128),
                                             c(0, 0, 255),
                                             c(0, 128, 128),
                                             c(0, 255, 255))/255))

HTMLcolors <- HTMLcolours

## NBS-ISCC Colour Dictionary
NBS <- read.table(system.file("Dictionaries", "NBS-ISCC-rgb.txt",
                              package="roloc"),
                  comment.char="!")
## Separate out components of colour names
## (so screen readers will have an easier time)
NBSnames <-
    gsub("(very|pale|ish|brilliant|strong|vivid|deep|moderate|light|dark|medium)",
         "\\1 ",
         gsub("yellowgreen", "yellow-green",
              gsub("orangeyellow", "orange-yellow",
                   gsub("olive(.)", "olive-\\1",
                        NBS$V4))))
NBScolours <- colourList(NBSnames, sRGB(as.matrix(NBS[1:3])/255))
NBScolors <- NBScolours

## Resene Colour Dictionary
Resene <- read.table(system.file("Dictionaries", "Resene-2010-rgb.txt",
                                 package="roloc"),
                     comment.char="!")
ReseneColours <- colourList(Resene$V4, sRGB(as.matrix(Resene[1:3])/255))
ReseneColors <- ReseneColours

## My own construction
## Hues based on 1908 colour wheel
## https://en.wikipedia.org/wiki/Color_wheel#/media/File:RGV_color_wheel_1908.png
## https://en.wikipedia.org/wiki/Color_wheel
luminance <- c("very light", "light", "", "dark", "very dark")
chroma <- c("bright", "vivid", "", "dull", "greyish")
hue <- c("red", "yellow", "green", "cyan", "blue", "magenta")
luminanceNum <- c(90, 70, 50, 30, 10)
chromaNum <- c(90, 70, 50, 30, 10)
hueNum <- seq(0, 300, 60)
grey <- c("white",
          paste(c("very light", "light", "medium", "dark", "very dark"),
                "grey"),
          "black")
greyNum <- c(100, seq(90, 10, -20), 0)
colourNames <- c(gsub(" +", " ", 
                      gsub("^ +| +$", "",
                           apply(expand.grid(chroma, luminance, hue), 1, 
                                 paste, collapse=" "))),
                 grey)
colours <- c(apply(expand.grid(chromaNum, luminanceNum, hueNum), 1, 
                               function(x) hcl(x[3], x[1], x[2])),
             hcl(0, 0, greyNum))
simpleColours <- colourList(colourNames, hex2RGB(colours))
simpleColors <- simpleColours

## Maori colour names
## http://www.maori.org.nz/kotereo/default.php?pid=sp148&parent=115
NgaTae <- colourList(names=c("Ma",
                             "Pango", "Mangu", 
                             "Kikorangi", "Kahurangi",
                             "Kakariki",
                             "Maota",
                             "Kowhai",
                             "Tawa", "Poroporo",
                             "Parauri", "Pakaka",
                             "Kiwikiwi",
                             "Karaka", "Parakaraka",
                             "Whero", "Kura",
                             "Mawhero"),
                     colours=sRGB(rbind(c(255, 255, 255),
                                        c(0,0,0), c(0,0,0),
                                        c(0, 0, 255), c(0, 0, 255),
                                        c(0, 128, 0),
                                        c(0, 255, 0),
                                        c(255, 255, 0),
                                        c(128, 0, 128), c(128, 0, 128),
                                        c(153, 51, 0), c(153, 51, 0),
                                        c(192, 192, 192),
                                        c(255, 165, 0), c(255, 165, 0),
                                        c(255, 0, 0), c(255, 0, 0),
                                        c(255, 192, 203))/255))
