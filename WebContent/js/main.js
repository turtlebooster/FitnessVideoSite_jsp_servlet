let xhr = new XMLHttpRequest();
xhr.onreadystatechange = responseVideo;
xhr.open("POST", "main");
//xhr.open("GET", "main?action=list");
xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xhr.send("action=list");

let videoList;
function responseVideo() {
    // 완벽하게 통신이 끝났을 때
    if (xhr.readyState == 4) {
        // 에러 없이 응답이 성공적으로 처리가 되었을때
        if (xhr.status == 200) {
            let videoHtml = "";
            videoList = JSON.parse(xhr.response);
            let recommendList = JSON.parse(xhr.response);
            videoList.forEach(video => {  
                videoHtml += `
                <div class="card">
                <a href="/ssafit/ssafit/main?action=detail&videoId=${video.id}">
                <img
                width="320"
                height="180"
                src="https://img.youtube.com/vi/${video.id}/mqdefault.jpg"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
                ></a>
                  <div class="card-body" >
                    <h6 class="card-title" style="width:300px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">${video.title}</h8>
                    <div class="d-flex justify-content-between">
                		<span class="card-text">#${video.part}</span>
                		<span class="card-text"><i class="bi bi-eye"></i> ${video.viewCnt}</span>
                	</div>
                </div>
                </div>`
            });
            document.querySelector("#video-area").innerHTML = videoHtml;
            
            // 추천영상 
            recommendList.sort(function(a,b){
            	return (a.viewCnt - b.viewCnt)*-1;
            })
            let recommendVideoHtml = "";
            for(let i = 0; i < 3; i++){
            	recommendVideoHtml += `
                    <div class="card">
                    <a href="/ssafit/ssafit/main?action=detail&videoId=${recommendList[i].id}">
                    <img
                    width="320"
                    height="180"
                    src="https://img.youtube.com/vi/${recommendList[i].id}/mqdefault.jpg"
                    title="YouTube video player"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen
                    ></a>
                      <div class="card-body" >
                        <h6 class="card-title" style="width:300px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">${recommendList[i].title}</h8>
	                    <div class="d-flex justify-content-between">
	                		<span class="card-text">#${recommendList[i].part}</span>
	                		<span class="card-text"><i class="bi bi-eye"></i> ${recommendList[i].viewCnt}</span>
	                	</div>                        
                    </div>
                    </div>`
            }
            document.querySelector("#recommend-video-area").innerHTML = recommendVideoHtml;
        }
    }
}

let partList = document.getElementsByClassName("part");
let partMap = new Map();

// 전체 눌렀을때
partList[0].addEventListener("click", () => {
	if (partList[0].ariaPressed === "true") {
		for (let i = 1; i < partList.length; i++){
			partList[i].setAttribute('class' , 'part btn btn-outline-dark');
			partList[i].setAttribute('aria-pressed' , 'false');
		}
	}
});

for (let i = 1; i < partList.length; i++) {
    partList[i].addEventListener("click", () => {
    	if (partList[i].ariaPressed === "true") {
    		partList[0].setAttribute('class' , 'part btn btn-outline-dark');
			partList[0].setAttribute('aria-pressed' , 'false');
    	}
    });
}

for (let i = 0; i < partList.length; i++) {
    partList[i].addEventListener("click", () => checkPartBtn());
}

function checkPartBtn() {
	for (let i = 0; i < partList.length; i++) {
	    partMap.set(partList[i].value, partList[i].ariaPressed);	 
	}
	let videoHtml = "";
    videoList.forEach(video => {         
        if (partMap.get("전체") === "true" || partMap.get(video.part) === "true"){
            videoHtml += `
            <div class="card">
            <a href="/ssafit/ssafit/detail?videoId=${video.id}">
            <img
            width="320"
            height="180"
            src="https://img.youtube.com/vi/${video.id}/mqdefault.jpg"
            title="YouTube video player"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
            ></a>
            <div class="card-body" >
            <h6 class="card-title" style="width:300px; padding:0 5px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap">${video.title}</h8>
            <p class="card-text">#${video.part}</p>
        </div>
        </div>`
        }
    });

    document.querySelector("#video-area").innerHTML = videoHtml;
}