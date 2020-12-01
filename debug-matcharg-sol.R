#
match.arg <- function(arg, choices, several.ok = FALSE) {
  # if choices is not specified...
  if (missing(choices)) {
    # ... return the integer index of the frame of the call stack in which 
    # match.arg() was called - is done with function sys.parent()
    # use that index to access the code behind the function 
    # and save the arguments with the help of formals() 
    formal.args <- formals(sys.function(sysP <- sys.parent()))
    # look up the input variable in the top-level function which 
    # is used as "arg"
    # extract the expression representing the admissible values 
    # of this variable from "formal.args"
    # this expression is evaluated with eval() in the environment in 
    # which match.arg() was called, 
    # wich results in the vector of admissible values
    choices <- eval(formal.args[[as.character(substitute(arg))]], 
                    envir = sys.frame(sysP))
  }
  # if "arg" is NULL, use the first admissible value  (equal to set as default)
  if (is.null(arg)) 
    return(choices[1L])
  # otherwise check if the argument is a character
  else if (!is.character(arg)) 
    stop("'arg' must be NULL or a character vector")
  # if several.ok is set to FALSE, check if the argument... 
  if (!several.ok) {
    # ...fits to one but only one choice
    if (identical(arg, choices)) 
      return(arg[1L])
    # ...or if not if its length is greater than 1 
    if (length(arg) > 1L) 
      stop("'arg' must be of length 1")
  }
  # if arg is empty return an error
  else if (length(arg) == 0L) 
    stop("'arg' must be of length >= 1")
  # see if a part of arg matches if one of the choices 
  # duplicates.ok is set to TRUE because it's (less than) slightly faster than
  # setting it to FALSE but produces the same outputs if arg has length of 1
  i <- pmatch(arg, choices, nomatch = 0L, duplicates.ok = TRUE)

  if (all(i == 0L)) 
    # if there is no match return an error
    stop(gettextf("'arg' should be one of %s", paste(dQuote(choices), 
                                                     collapse = ", ")), domain = NA)
  ###########
  # isn't this part kind of redundant since there have already been checks, 
  # that arg may only have a length of 1?
  ###########      
  i <- i[i > 0L]
  if (!several.ok && length(i) > 1) 
    stop("there is more than one match in 'match.arg'")
  
  # return the choice which is most likely chosen
  choices[i]
}


make_something <- function(something = c("mess", "cake", "hyuuge mistake")) {
  something <- match.arg(something)
  message("I made a", something, ".\n")
}

debugonce(match.arg)
make_something(c("mess","cake"))
