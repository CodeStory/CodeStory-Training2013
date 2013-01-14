### stripgain

#### goal
Strip gain and output it as plain text

#### usage

	echo "{\"gain\":34,\"polka\":43}" | coffee stripgain.coffee

will output

	34

### simple-generator

#### goal
Generate simple question (< 40 trips) to be sent to players

#### usage

Generating a 10 trips file (2 is the number of iterations, each iteration is of 5 trips)

	coffee simple-generator.coffee 2

will output on stdout

	[{"name":"alive-transportation-61","start":0,"length":4,"price":11},{"name":"little-vegan-95","start":1,"length":2,"price":4},{"name":"cooperative-sculptor-10","start":2,"length":6,"price":7},{"name":"cruel-coal-54","start":4,"length":5,"price":19},{"name":"rich-shoeshine-42","start":5,"length":2,"price":28},{"name":"ancient-jar-40","start":5,"length":4,"price":7},{"name":"ancient-image-25","start":6,"length":2,"price":6},{"name":"large-eggshell-78","start":7,"length":6,"price":5},{"name":"careful-against-7","start":9,"length":5,"price":12},{"name":"perfect-flame-78","start":10,"length":2,"price":24}]

##### Details
* as of now, this generator will not produce more than 40 trips, so 8 is the max value.
* default value if no arguments are given is 3 so 15 trips


### check.coffee

#### goal
check.coffee takes :
* the answer of the player as a argv
* the question in json in stdin
compute the answer to the question, check it with the supplied answer from the player and output `OK or KO`

#### usage

	cat somequestion.json | coffee check.coffee 42

somequestion.json contains something like

	{"name":"quiet-clothing-45","start":0,"length":4,"price":8},{"name":"eager-curb-78","start":1,"length":2,"price":5},{"name":"happy-cheekbone-16","start":2,"length":6,"price":4},{"name":"proud-schoolgirl-17","start":4,"length":5,"price":18},{"name":"plain-obesity-30","start":5,"length":2,"price":16}]




### lags-answers

#### goal
the lags-answers.coffee does the same thing as the script, but compute the answer and calculate the time it took to answer it.

#### usage

	coffee lags-answers.coffee 6

will output to stdout

	Generation of 15 Trips
	   QUESTION   
	[{"name":"tough-radar-52","start":0,"length":4,"price":10},{"name":"cooperative-kindergarten-1","start":1,"length":2,"price":5},{"name":"cloudy-wax-80","start":2,"length":6,"price":5},{"name":"splendid-scoreboard-61","start":4,"length":5,"price":15},{"name":"cooperative-newscaster-86","start":5,"length":2,"price":30},{"name":"selfish-buggy-57","start":5,"length":4,"price":10},{"name":"adventurous-hyacinth-38","start":6,"length":2,"price":2},{"name":"wide-racketeering-8","start":7,"length":6,"price":6},{"name":"joyous-cervix-14","start":9,"length":5,"price":9},{"name":"strange-squadron-85","start":10,"length":2,"price":14},{"name":"soft-seesaw-9","start":10,"length":4,"price":12},{"name":"gifted-rigging-66","start":11,"length":2,"price":1},{"name":"nervous-wintergreen-91","start":12,"length":6,"price":7},{"name":"gigantic-crossbones-77","start":14,"length":5,"price":11},{"name":"frightened-jock-1","start":15,"length":2,"price":6}]
	   ANSWER   
	65
	compute: 3ms



#### lags-test

#### goal
unit test for lags.coffee

#### usage

	mocha --compilers coffee:coffee-script lags-test.coffee

#### output

	  ․․․․․․․․․․․․․․․․․
	
	  ✔ 17 tests complete (3 ms)
	
