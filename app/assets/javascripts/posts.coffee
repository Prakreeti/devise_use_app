$(document).ready ->
	$('.comment-reply').on 'click', ->
		$("#replies_" + ($(this).attr('id').split "_")[1]).toggle()

	$('.replyto').on 'click', ->
		$("#repliesto_" + ($(this).attr('id').split "_")[1]).show()
		