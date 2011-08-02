# Netflix Instant Browser

Node.js + shared Jade views via Stitch

This is a proof of concept Javascript app that is fully functional on
both the client and server side without copious amounts of code
repititon. The one major piece of the app that both the server and the
client need are templates, which in most cases would require maintaining
two sets of templates - one for the server and one for the client.

With node.js and Stitch, however, we can use the exact same views on the
client and the server, removing most of the potential for code duplication
and maintenance hassles. And with `history.pushState`, we make URLs that work
anywhere, and on the initial page load don't require Javascript.
