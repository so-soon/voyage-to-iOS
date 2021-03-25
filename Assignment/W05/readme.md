#VTiOS W05

<h2>Assignment</h2>

주문 어플리케이션

![Simulator Screen Shot - iPhone 12 - 2021-03-25 at 18 56 54](https://user-images.githubusercontent.com/59683503/112454312-e5378380-8d9b-11eb-80ef-14f0b0ab4001.png)
![Simulator Screen Shot - iPhone 12 - 2021-03-25 at 18 56 59](https://user-images.githubusercontent.com/59683503/112454321-e799dd80-8d9b-11eb-941e-187249b83cf5.png)


- 2개의 View 구성
- 1번째 뷰에 서버에서 메뉴 목록을 받아온다.
- 각 셀별 플러스,마이너스 버튼으로 개수 조정
- 뷰 하단에 총 가격 합계 표시
- Order는 clear가능(스샷참고)
- 오더 버튼으로 2번째 뷰로 넘어감
- 2번째 뷰는 주문한 총 아이템 이름 리스트 보여줌
- 총 합 가격(주문한 가격+ 10% VAT) 표시

- RxSwift계열을 사용해서 구현해보기!


> Hint : TableView,Alamofire(URLSession으로도 가능), PerformSegue

- Advanced : 주문 목록을 서버에서 불러올때 로딩(Activity Indicator)표시, 만약 서버에서 불러오는것이 실패했을 경우 MockData 표시
