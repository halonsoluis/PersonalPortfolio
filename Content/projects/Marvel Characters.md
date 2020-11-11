---
date: 2017-11-10 23:24
description: A description of my first post.
tags: first, article
---

## Marvel Characters

[Marvel Characters](https://gitlab.com/hugoalonsoluis/marvel-characters) is a take-home project I completed as part of the interview process for an iOS Developer role in Portugal.

The prototype/design was provided as a [Marvel Prototype](https://marvelapp.com/279b309/screen/10499832). The main idea was to present data from the [Marvel API](https://developer.marvel.com/).

<!-- Portfolio Gallery Grid -->

<p align="center">

<img src="../../images/marvel/marvel_characters_list.png" width="230">
<img src="../../images/marvel/marvel_characters_detail.png" width="230">
<img src="./images/marvel/marvel-characters-transitions-video.gif" width="195">
</p>

### My contribution

I created a completely functional version in approximately 14 days using Swift 3, [RxSwift](https://github.com/ReactiveX/RxSwift) and Storyboards. It uses [Alamofire](https://github.com/Alamofire/Alamofire) for networking and [KingFisher](https://github.com/onevcat/Kingfisher) for the caching of images. For handling dependencies it was used [Carthage](https://github.com/Carthage/Carthage).

This was the first time I used blur effects and custom transitions in an app, and I ❤️it!

Later on, I started experimenting with it and it has been my playground for testing and Continuous Integration using [GitlabCI](https://about.gitlab.com/product/continuous-integration/). Currently is updated to Swift 5.

- [Gitlab link to the project (original)](https://gitlab.com/hugoalonsoluis/marvel-characters)
- [Github link to the project](https://github.com/halonsoluis/marvel-characters)
