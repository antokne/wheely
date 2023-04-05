# wheely
Simple wheel of fortune app written in SwiftUI

A technical challenge.

Some notes:
* With more time, I might have put some things in separate packages,
* I would like to add more tests,
* I really want to be able to spin the wheel with a finger flick but that is a bit more complex,
* I also would like to tune automatic colour selection for each segment - currently does not really choose nice colours nor does it use current colours (and exclude those). A colour blind option would also be nice,
* I did not do any custom design with the screens or fonts,
* Currently cannot edit an existing value. It would be very easy to add this,
* I kind of went into a bit more detail when I decided to save the colour as it did not implement Codeable. But was good to try this anyway.
* For simplicity I chose to use JSON as the backing store for peristence. I would normally use CoreData or perhaps some cloud based model for this.

I’m sure there is a few more things there. But overall pretty happy with it. 
