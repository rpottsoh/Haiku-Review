# Haiku Review
Haiku is an ancient form of Japanese poetry. A Haiku is a three-line poem with seventeen syllables, where the first line must contain five syllables, the second line must contain seven syllables, and the third line must contain five syllables. The lines do not have to rhyme. Here is an example, where slashes separate the lines:

`computer programs/The bugs try to eat my code/I must not let them`

You must write an algorithm that will review a Haiku and check that each line contains the correct number of syllables.

## Input

The input contains one or more lines, each of which contains a single Haiku. A Haiku will contain at least three words, and words will be separated by either a single space or a slash `(/)`. Slashes also separate the three lines of a Haiku, so each Haiku will contain exactly two slashes. *The three lines of the haiku will be contained within one physical line of the input.*

A Haiku will contain only lowercase letters `Aa-Zz`, forward slashes `/`, and spaces, and will be no more than 200 characters long, not counting the end-of-line characters.

Each Haiku is guaranteed to contain three lines, and each line will contain at least one word. Your job is to determine whether each line has the correct number of syllables `5/7/5`. For the purposes of this problem, every contiguous sequence of one or more vowels counts as one syllable, where the vowels are `Aa, Ee, Ii, Oo, Uu, & Yy`. Every word will contain at least one syllable.

*Note: This method of counting syllables does not always agree with English convention. In the second example below, your algorithm **must** consider the word `code` to have two syllables because the `o` and the `e` are not consecutive. However, in English, the `e` is silent and so `code` actually has only one syllable.*

## Output

For each Haiku, output a comma-separated single line that contains the number of syllables in each line, together with the letter Y if it is a Haiku, or N if it is not a Haiku (see below).

### Sample Input

`happy purple frog/eating bugs in the marshes/get indigestion`

`computer programs/the bugs try to eat my code/I will not let them`

### Sample Output

`5,7,5,Yes`

`5,8,5,No`

