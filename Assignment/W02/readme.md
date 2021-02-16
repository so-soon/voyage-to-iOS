<h1>VTiOS Week 02</h1>

- Assignment - Todos

  - 2개의 View로 구성된 앱
    - 첫번째 뷰 : 테이블 형태로 할일 리스트를 보여주는 뷰, 테이블 셀에는 할일의 이름과 날짜가 표시, 할일 추가하기 가능
    - 두번째 뷰 : 첫번째 뷰에서 테이블 셀을 터치하거나 할일 추가를 할때 보여지는 뷰, 할일의 이름과, 메모, 날짜, 알람 여부를 설정할 수 있음. **수정모드와 보기모드 전환 가능**
  - (Optional) 테이블 셀을 클릭하여 나오는 두번째 뷰는 "보기모드" + "Modal"로 나타남
  - 할일 데이터는 당연히 앱이 종료되어도 보존되어야 함.
  - 유저가 알람여부를 yes로 설정할 경우, 해당 시간에 맞춰 알람(noti)를 날려주어야 함.

  > Hint : TableView,UserNotifications, dateFormatter, navigation controller, segue, Codable

  > - 서로 배우기 위하여 따로 이미지로 UI를 제한하지는 않았습니다. 각자 창의적이고 효과적인 UI 기대할게요!(나부터..)
  >
  > - 데이터 저장은 UserDefaults가 아닌 방식으로 해봅시다.(실제로 이런 데이터는 userDefaults방식에 맞지 않음) 힌트는 Codable과 JSON입니다.



- Seminar
  - Reactive programming
    - RxSwift, RxJava, RxC++, RxKotlin, RxCocoa 등 갑자기 등장하는 Rx는 무엇이며, Functional Programming과는 무슨 관계일까!
    - Async한 데이터를 Async하고 깔끔하게 처리하는 법
  - Auto Reference Counting 
    - 우리가 Swift를 사용하며 메모리 걱정을 하지 않아도 되는 이유
  - UIAlertChain
    - 효율적인 User focus 제어방법
