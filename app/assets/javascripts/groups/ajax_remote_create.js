$(function(){
	$('#formGroup').on('ajax:success',function(e, data, status, xhr){
		//if success
		console.log(data.name);
		$('#table').append("<tr><td>"+data.name+"</td><td><a id='group"+data.id+"' href='#' class='addGroup'>Add</a></td><td><a data-confirm='Are you sure you want to delete group?' rel='nofollow' data-method='delete' href='/groups/"+data.id+"'>Destroy</a></td></tr>");

	}).on('ajax:error',function(e, data, status, xhr){
		// alert("Haloooooooooooooooooo");
		$('#groupErrors').text(data.responseText);
	})

});
