pandoc.horizontal.rule()
pandoc.horizontal.rule.return()
pandoc.header('foobar', level = 2)        # ATX style
pandoc.header('foobar', style = 'setext') # underlined
pandoc.link('example.com', 'Most popular URL')
pandoc.image('http://image.url', 'image caption')

##

pandoc.strong('foobar')
pandoc.strong.return('foobar')
pandoc.emphasis('foobar')
pandoc.strikeout('foobar')
pandoc.verbatim('foobar')

## 

pandoc.list(c('foo', 'bar'))

l <- list('First list element', paste0(1:2, '. subelement'),
  'Second element', list('F', 'B', 'I', c('phone', 'pad', 'talics')))
pandoc.list(l, 'roman')

##

pander(as.list(rownames(mtcars)))

##

pandoc.table(head(cars))

## 

pandoc.table(head(cars), style = 'rmarkdown')

##

pandoc.table(head(mtcars))

##

pandoc.table(head(mtcars), split.table = Inf)

##

df <- iris
df$Species <- as.character(df$Species)
df$Species[4] <- 'foos and bars'
names(df) <- gsub('.', ' ', names(df), fixed = TRUE)

pandoc.table(head(df, 4), split.table = Inf, split.cells = 5,
    style = 'grid', justify = 'center')

##

I_can_justify <- function(df)
    ifelse(sapply(df, is.numeric), 'right', 'left')

pandoc.table(head(df, 4), split.table = Inf, split.cells = 5,
    style = 'grid', justify = I_can_justify(head(df, 4)))

##

panderOptions('table.alignment.default',
    function(df) ifelse(sapply(df, is.numeric), 'right', 'left'))
panderOptions('table.style', 'grid')
panderOptions('table.split.cells', 5)
panderOptions('table.split.table', Inf)

pander(df)

##

methods(pander)

##

pander(1:10)
panderOptions('p.copula', ' og ') # Danish
pander(1:10)
pander(Sys.time())
pander(sessionInfo())
pander(sessionInfo(), compact = FALSE, locale = FALSE)

##

pander(head(cars, 2))
pander(summary(mtcars$hp))
pander(table(mtcars$am, mtcars$gear))

##

pander(list(top3 = head(cars, 3), bottom3 = tail(cars, 3)))

##

pander(chisq.test(table(mtcars$am, mtcars$gear)))

##

counts    <- c(18, 17, 15, 20, 10, 20, 25, 13, 12)
outcome   <- gl(3, 1, 9)
treatment <- gl(3, 3)
m <- glm(counts ~ outcome + treatment, family = poisson())
pander(m)

##

pander(anova(m))

panderOptions('missing', '')
pander(anova(m))

pander(aov(m))

##

pander(prcomp(USArrests))

##

pander(descr::CrossTable(mtcars$cyl, mtcars$gear))

##

library(tables)
pander(tabular(as.factor(am) ~ (mpg+hp+qsec) * (mean+median),
    data = mtcars))

##

library(memisc)
berk  <- Aggregate(Table(Admit,Freq) ~ .,data = UCBAdmissions)
berk0 <- glm(cbind(Admitted,Rejected) ~ 1, data = berk, family = "binomial")
berk1 <- glm(cbind(Admitted,Rejected) ~ Gender, data = berk, family = "binomial")
berk2 <- glm(cbind(Admitted,Rejected) ~ Gender + Dept, data = berk, family = "binomial")
pander(mtable(berk0, berk1, berk2, coef.style = 'horizontal',
    summary.stats = c('Deviance', 'AIC', 'N')), style = 'grid')

##

pander(formals(pandoc.table.return))

##

set.caption('Set your caption before printing.')
set.alignment('right')
pander(head(iris, 3), split.table = Inf)

##

pander(data.frame(A = 'The hyphen (-) is a punctuation mark used to join words and to separate syllables of a single word. The use of hyphens is called hyphenation.'),
    split.cells = 24,
    use.hyphening = TRUE)

##

emphasize.cols(1)
emphasize.rows(2)
pander(head(cars))

##

emphasize.strong.cells(which(head(cars) %% 2 == 0, arr.ind = TRUE))
pander(head(cars))

##

evals('chisq.test(mtcars$am, mtcars$gear)[[1]]')

##

x <- mtcars$hp
y <- 1e5
system.time(evals('sapply(rep(x, y), mean)'))

f <- sapply
g <- rep
h <- mean
X <- mtcars$hp * 1
Y <- 1000
system.time(evals('f(g(X, Y), h)'))

##

x <- Pandoc.brew(text = '
Pi equals to <%=pi%>, and the best damn cars are:
<%=head(mtcars, 2)%>
')

str(x)

##

Pandoc.brew('4.brew')

##

# panderOptions('graph.fontfamily', "Comic Sans MS")
# panderOptions('graph.fontsize', 18)
# panderOptions('graph.fontcolor', 'blue')
# panderOptions('graph.grid.color', 'blue')
# panderOptions('graph.axis.angle', 3)
# panderOptions('graph.boxes', T)
# panderOptions('graph.legend.position', 'top')
# panderOptions('graph.colors', rainbow(5))
# panderOptions('graph.grid', FALSE)
# panderOptions('graph.symbol', 22)

# hist(df$hp, main = "Histogram in base R")
# histogram(df$hp, main = "Histogram with lattice")
# ggplot(df) + geom_histogram(aes(x = hp), binwidth = 50) +
#     ggtitle("Histogram with ggplot2")

##

myReport <- Pandoc$new('Gergely Daroczi', 'Demo')

myReport$add.paragraph('Hello there, this is a really short tutorial!')

fit <- with(lm(mpg ~ hp + wt), data = mtcars)
myReport$add(fit)

myReport$add(plot(fit))

myReport$export()
myReport$export('html')
myReport$export('docx')

##

library(rapport)
rapport('5.rapport', v = 'hp', data = mtcars)
