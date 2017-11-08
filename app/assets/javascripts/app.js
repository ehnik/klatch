var ready;
var totalCommentCount = 0;
ready = function(){

$( ".show-more-button" ).click(function(evt) {
  var loopClass = evt.currentTarget.classList[1]
  target = evt.currentTarget

  $( "div.comment-container."+loopClass).toggleClass("show")
  $( "div.reply."+loopClass).toggleClass("show")
  nav = $("#discussion-nav")
  threadCommentCount = target.dataset.number
  totalCommentCount = nav[0].dataset.comments

  if ($(evt.currentTarget).hasClass("new")){
      $(evt.currentTarget).html("Show discussion with " + target.dataset.name)
    if (totalCommentCount-threadCommentCount>0){
      $("#discussion-nav").html("Discussions (" + (totalCommentCount-threadCommentCount) +")")
      totalCommentCount = (totalCommentCount-threadCommentCount)
      $('#discussion-nav').attr('data-comments',totalCommentCount)
    }
    else {
      $("#discussion-nav").html("Discussions")
      totalCommentCount = 0
      $('#discussion-nav').attr('data-comments',totalCommentCount)
    }

    $(evt.currentTarget).removeClass("new")
    $.ajax({
      url: "/user/1/comments",
      type: "get", //send it through get method
      data: {
        threadClicked: evt.currentTarget.id
      },
      success: function(response) {
      },
      error: function(xhr) {
      }
    });
    };
  })

  $(".welcome-button").click(function(evt){
    $(".welcome").addClass("hide")
  })

  $(".welcome-hide-button").click(function(evt){
    $(".welcome-hide").removeClass("show")
  })

  $(".about").click(function(evt){
    $(".welcome-hide").toggleClass("show")
  })

  $(".localize").each(function() {
  postDate = moment(this.textContent)
  d = new Date()

  if (postDate.date()==d.getDate()){
    this.textContent = moment(this.textContent).format('LT');
  }
  else if (postDate.year()==d.getFullYear()) {
    this.textContent = moment(this.textContent).format('MMMM D');
  }
  else  {
    this.textContent = moment(this.textContent).format('MMMM YYYY');
  }

  })


}

//$(document).ready(ready);
//$(document).on("page:load", ready);
$(document).on("turbolinks:load", ready);
