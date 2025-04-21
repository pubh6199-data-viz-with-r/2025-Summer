lesson <- strsplit(here::here(), "/")[[1]]
lesson <- lesson[length(lesson)]

# Build the slides
renderthis::to_html("index.Rmd", "index.html")
renderthis::to_pdf("index.html", paste0(lesson, ".pdf"))

# Compress the PDF to reduce size
tools::compactPDF(paste0(lesson, ".pdf"), gs_quality = 'ebook')

files1 <- c( 
  'data',
  'practice-solutions.qmd',
  'practice.qmd',
  'quarto_demo.qmd'
)
files2 <- c(
    'data',
    'practice-solutions.qmd',
    'practice.qmd'
)
files3 <- files2
files4 <- files2
files5 <- files2
files6 <- files2
files8 <- files2
files9 <- files2
files10 <- files2
files11 <- files2

files13 <- c(
    'caseConverter_solution.R',
    'caseConverter.R',
    'data',
    'internetUsers_solution.R',
    'internetUsers.R',
    'mpg.R',
    'practice-solutions.qmd',
    'practice.qmd',
    'shinyWidgets.R',
    'widgets.R'
)

# Create zip files of class notes
zip::zip(
    zipfile = paste0(lesson, ".zip"),
    files = c(files13, paste0(lesson, ".Rproj"))
)
