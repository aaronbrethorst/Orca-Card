What's This Now?
===========

I want to be able to view the balance on my Seattle public transit Orca card on my iPhone but, the Orca website sucks. A lot. Especially on the iPhone.

So, I banged out this app in an afternoon. Of course, Orca's Terms of Use prohibit me from publishing this iPhone app to the App Store. So, I'm doing the next best thing: publishing all of the source code under a generally permissive license. Hopefully this will prove to be of some benefit to others.

![Screenshot of App](https://github.com/aaronbrethorst/Orca-Card/raw/master/screenshot.jpg)

Third Party Components
===========

Orca Balance wouldn't exist were it not for the generosity of others in the Mac and iOS development community. It uses:

*	SVProgressHUD - https://github.com/samvermette/SVProgressHUD - MIT License
*	(A rather hacked up version of) AFNetworking - https://github.com/gowalla/afnetworking - MIT License
* 	SFHFKeychain - https://github.com/ldandersen/scifihifi-iphone/tree/master/security - MIT License
* 	XPathQuery - http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html - "zlib"-style license (see: http://projectswithlove.com/about.html)
* 	JSONKit - https://github.com/johnezang/JSONKit (It's a dependency of AFNetworking, don't actually think that the Orca website is so friendly as to vend JSON...) - Apache 2.0 License

MIT License
==========

Copyright (c) 2011 Aaron Brethorst.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.