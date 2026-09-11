/**
 * 지용 지용 강간범
 * 지용 ㅣㅈ용 범죄자
 * 지용 지용 
 */

function checkAddProduct(){
	/* 
	[1]상품 아이디: 첫글자를 p로 시작하고 숫자를 조합해서 5-6자리 입력
	[2]상품명: 최소 2자에서 최대 20자까지 입력
	[3]상품가격: 숫자만 입력, 0이상 입력
	[4]재고수: 숫자만 입력
	[5]
	 */
	
	
	
	
	var name = document.getElementById("pname");
	var unitPrice =document.getElementById("unitPrice");
	var unitsInStock =document.getElementById("unitsInStock");
	var img = document.getElementById("productImage");
	var productId = document.getElementById("productId");
	
	function check(regExp, e, msg){
			if(regExp.test(e.value)){
				return true; //submit하겠다
			}
			else{
				alert(msg);
				e.select();
				e.focus();
				return false; //submit하지 않겠다 
			}
	}
	if (!check(/^P[0-9]{4,5}$/, productId, "[상품 아이디]\n첫글자를 P로 시작하고 숫자를 조합해서 5-6자리 입력 가능합니다.")){
		productId.focus();
		productId.select();
		return false;
	}
	
		
	if(name.value.length < 2 || name.value.length > 20){
		alert("[상품명]\n최소 2자에서 최대 20자까지 입력 가능합니다.");
		name.focus();
		name.select();
		return false;
	}
	
	if(unitPrice.value.length == 0 || isNaN(unitPrice.value)){
		alert("[상품가격]\n숫자만 입력 가능합니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	
	
	if(Number(unitPrice.value <= 0)){
		alert("[상품가격]\n0이나 음수를 입력할 수 없습니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	else if(!/^\d+$/.test(unitPrice.value)){
		alert("[상품가격]\n숫자(정수)만 입력 가능합니다.");
		unitPrice.focus();
		unitPrice.select();
		return false;
	}
	if(unitsInStock.value.length == 0 || isNaN(unitsInStock.value)){
		alert("[재고수]\n숫자만 입력 가능합니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
	
	if(unitsInStock.value < 0){
		alert("[재고수]\n음수를 입력할 수 없습니다.");
		unitsInStock.focus();
		unitsInStock.select();
		return false;
	}
	
	
	if(!(img.value)){
		alert("제품의 이미지를 첨부해 주세요.");
		return false;
	}
	
	document.newProduct.submit();
	
	
	
}


