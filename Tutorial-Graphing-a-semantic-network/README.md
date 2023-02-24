# Tutorial-Graphing-a-semantic-network
Learn about working with graphs in R, by building graphs to visualize the semantic network for animals. The tutorial is intended for people with only a little knowledge of R and/or graphs.

Each **listX.txt** file contains a list of animals produced by a single volunteer in an *animal-fluency task*. Each volunteer was given two minutes to type out as many animals as she could think of, in whatever order they occurred to her. The tutorial works through the process of reading these data into R and using the **igraph** and **visNetwork** packages to construct a network that captures links in memory amongst the various animals produced. You can add your own data, or those of others, by just adding new listX.txt files.

The tutorial is written as both a JuPyteR notebook and a plain html file. If you have JuPyteR, just clone or download the repository, open the notebook, and you're off. The notebook must be in the same directory as the listX.txt files. If you don't have JuPyteR but want to run through the tutorial in R or RStudio, just open the .html file, and copy-and-paste the blocks of R text from your browser into your console. In this case, make sure to set the R working directory to the location where the listX.txt files reside.


