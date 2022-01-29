//
//  Constant.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import Alamofire

struct Constant {
    static let BASE_URL = "URL 주소를 입력해주세요"
    static let KOBIS_BASE_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest"
    
    //
    static let search_Text = "어떤 여행지를 선택할까요?"
    static let main_Text = "잉여 티켓을 저렴하게 ZOOP !"
    
    static let city = ["서울","경기","인천","강원","경남","경북","광주","대구","대전","세종","부산","울산","전남","전북","제주","충남","충북"]
    static let region = [
        "서울" : [
            "강남구",
            "강동구",
            "강북구",
            "강서구",
            "관악구",
            "광진구",
            "구로구",
        ],
        "경기" : [],
        "인천" : [],
        "강원" : [],
        "경남" : [],
        "경북" : [],
        "광주" : [],
        "대구" : [],
        "대전" : [],
        "세종" : [],
        "부산" : [],
        "울산" : [],
        "전남" : [],
        "전북" : [],
        "제주" : [],
        "충남" : [],
        "충북" : []
    ]
    
    static let url = "http://52.79.160.36:8080"
}
