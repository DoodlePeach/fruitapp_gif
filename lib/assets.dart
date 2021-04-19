// This file contains the paths of the assets that are used throughout the app,
// as well as their descriptions.
// Since thse are static and are not that many, we can just store them like this.

// Base path where the fruits are stored.
final basePath = "assets/fruits/";

// These are 3 placeholder descriptions of the fruits.
final dummyDescription1 =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book";
final dummyDescription2 =
    "Pellentesque venenatis ex sit amet porta faucibus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce porta, ligula eu tincidunt dapibus, mauris purus sollicitudin ex, sed placerat libero ligula sit amet turpis. ";
final dummyDescription3 =
    "Duis id tortor ac nunc aliquet vestibulum. Donec bibendum lorem vitae nulla commodo, at fermentum metus dictum. Pellentesque nec lorem quam.";

// The paths of fruits, where their default images are in [image], and the
// the paths of different colors are in [variants] key, as well as the
// [description]s of each fruit varient.
final Map details = {
  "watermelon": {
    "image": "watermelon/1.png",
    "variants": {
      "red": "1.png",
      "white": "2.png",
      "green": "3.png",
      "grey": "4.png",
      "black": "5.png",
      "blue": "6.png",
      "orange": "7.png",
      "yellow": "8.png"
    },
    "description": {
      "red": dummyDescription1,
      "white": dummyDescription2,
      "green": dummyDescription3,
      "grey": dummyDescription1,
      "black": dummyDescription2,
      "blue": dummyDescription3,
      "orange": dummyDescription1,
      "yellow": dummyDescription2
    },
  },
  "apple": {
    "image": "apple/1.png",
    "variants": {
      "red": "1.png",
      "white": "2.png",
      "green": "4.png",
      "grey": "8.png",
      "black": "5.png",
      "blue": "7.png",
      "orange": "6.png",
      "yellow": "3.png"
    },
    "description": {
      "red": dummyDescription1,
      "white": dummyDescription2,
      "green": dummyDescription3,
      "grey": dummyDescription1,
      "black": dummyDescription2,
      "blue": dummyDescription3,
      "orange": dummyDescription1,
      "yellow": dummyDescription2
    },
  },
  "banana": {
    "image": "banana/1.png",
    "variants": {
      "red": "6.png",
      "white": "4.png",
      "green": "5.png",
      "grey": "7.png",
      "black": "3.png",
      "blue": "8.png",
      "orange": "2.png",
      "yellow": "1.png"
    },
    "description": {
      "red": dummyDescription1,
      "white": dummyDescription2,
      "green": dummyDescription3,
      "grey": dummyDescription1,
      "black": dummyDescription2,
      "blue": dummyDescription3,
      "orange": dummyDescription1,
      "yellow": dummyDescription2
    },
  },
  "pear": {
    "image": "pear/1.png",
    "variants": {
      "red": "2.png",
      "white": "6.png",
      "green": "1.png",
      "grey": "7.png",
      "black": "3.png",
      "blue": "8.png",
      "orange": "5.png",
      "yellow": "4.png"
    },
    "description": {
      "red": dummyDescription1,
      "white": dummyDescription2,
      "green": dummyDescription3,
      "grey": dummyDescription1,
      "black": dummyDescription2,
      "blue": dummyDescription3,
      "orange": dummyDescription1,
      "yellow": dummyDescription2
    },
  },
};
