// ---------------------------
// Constructor
// ---------------------------
// BusyBox class constructor
// Arguments:
//
//   varName - name of the variable this instance of the busy box is assigned to.
//   imageCount - number of image in the animation sequence.
//   imageNamePrefix - name prefix for each image.
//   imageNameSuffix - name suffix for each image.
//   imageDelay - number of milliseconds to display each image.
//
//   This example uses the default busy box layout defined internally (in the javascript).
//   var busyBox = new BusyBox("BusyBox1", 4, "gears_ani_", ".gif", 125)
//
function BusyBox(varName, imageCount, imageNamePrefix, imageNameSuffix, imageDelay)
{
  // Initialize object
  this.VarName = varName;
  this.ImageCount = imageCount;
  this.ImageNamePrefix = imageNamePrefix;
  this.ImageNameSuffix = imageNameSuffix;
  this.ImageDelay = imageDelay;

  // Allows us to stop the animation with clearTimeout(), should we ever want t
  this.timeout_id = null;

  // Cache (pre-load) imageso
  this.CurrentImageIndex = 0;
  this.CacheImages();

  // Get reference to the IFrame object
  this.div = document.getElementById("BusyBoxDiv");
  this.img = document.getElementById("BusyBoxImg");

  // Hide the busy box
  this.Hide();
}

// --------------------------------
// Instance Methods
// --------------------------------


// Center:
// Centers the busy box IFrame on the page regardless of the browsers
// scroll position.  This ensures the busy box is presented to the user
// in a visible location in the window.
BusyBox.prototype.Center = function()
{
  var div = this.div;

  // Center the BusyBox in the window regardless of the scroll positions
  var objLeft = (document.body.clientWidth - div.offsetWidth) / 2;
  var objTop = (document.body.clientHeight - div.offsetHeight) / 2;
  objLeft = objLeft + document.body.scrollLeft;
  objTop = objTop + document.body.scrollTop;

  // Position object
  div.style.position = "absolute";
  div.style.top = objTop;
  div.style.left = objLeft;
}


// CacheImages:
// Pre-loads the images from the server and stores a reference to each
// image.  This allows the images to be presented to the user quickly
// for smooth image animation.
BusyBox.prototype.CacheImages = function()
{
  // Instantiate the array to store the image references
  this.Images = new Array(this.ImageCount);

  // Load all the images to cache into the aniframes array
  for(var i = 0; i < this.ImageCount; i++)
  {
    this.Images[i] = new Image();
    this.Images[i].src = '../system/images/' + this.ImageNamePrefix + i + this.ImageNameSuffix;
  }
}


// IsAnimating:
// Returns a boolean value representing the state of the animation.
BusyBox.prototype.IsAnimating = function()
{
  return this.timeout_id != null;
}


// IsVisible:
// Returns a boolean value representing the visibility state for the busy box.
BusyBox.prototype.IsVisible = function()
{
  return this.div.style.visibility == "visible" && this.div.style.width > 0;
}


// Animate:
// Performs the animation process.  This is accomplished by showing the "current"
// image in the animation sequence process; and then submitting a timed statement
// to execute in x number of milliseconds.
BusyBox.prototype.Animate = function()
{
  this.img.src = this.Images[this.CurrentImageIndex].src;

  // Auto re-center and re-size the busy box.  This will force the busy box to
  // always appear in the center of the window even if the user scrolls.
  this.Center();

  // Increment the current image index
  this.CurrentImageIndex = (this.CurrentImageIndex + 1)%this.ImageCount;

  // Display the next image in (imageDelay value) milliseconds (i.e. 125)
  this.timeout_id = setTimeout(this.VarName + ".Animate();", this.ImageDelay);
}


// StartAnimation:
// Starts the animation process.
BusyBox.prototype.StartAnimate = function()
{
  if( this.IsAnimating() )
    return;

  this.Animate();
}


// StopAnimation:
// Stops the animation process.
BusyBox.prototype.StopAnimate = function()
{
  clearTimeout(this.timeout_id);
  this.timeout_id = null;
}


// Hide:
// Hides the busy box making it invisible to the user.
BusyBox.prototype.Hide = function()
{
  this.StopAnimate();

  // Hide the busy box.
  this.div.style.left = "-1000px";
  this.div.style.top = "-1000px";
}


// Show:
// This function displays the busy box to the user.  This function centers the
// busy dialog box, makes it visible, and starts the animation.  This function
// will typically be called by the body event.
//
// Example:
//    <body onbeforeunload="busyBox.Show();" >
BusyBox.prototype.Show = function()
{
  if( this.IsAnimating() || this.IsVisible() )
    return;

  this.Center();

  // Set the busy box to be visible and make sure it is on top of all other controls.
  this.div.style.visibility = "visible";
  this.div.style.zIndex = "999999";

  // Start the animation
  this.StartAnimate();
}
