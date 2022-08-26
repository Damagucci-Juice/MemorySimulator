# PhotosAlbum

비동기를 이해하기 위해 시작한 사진을 보여주는 어플리케이션

- - - -

## 프로젝트 초기 화면 구성
<img src="https://user-images.githubusercontent.com/50472122/186804777-8c95db6b-ae90-4662-a9c1-32fcb4cd8383.png" width="200" height="430"/>

## 작업내용(22.08.26)
  - [x] CollectionView 를 이용해 Cell 을 채색한다.
  - [x] VC 에서 많은 코드가 있지 않고 기능들을 분리한다. 
  - [x] AutoLayout 을 사용하고 오류메세지가 나지 않게 조정

## 고민과 해결
- `Delegate` 파일을 따로 분리했는데, `DelegateFlowLayout` 이 적용이 안되는 버그
  - `DelegateFlowLayout` 안에 델리게이트와 레이아웃에 관한 코드가 같이 적용되서 그런 버그가 나타났다.
- Cell 에서 imageView 를 추가했는데, 이 뷰의 `Constraints`가 충돌
  - imageView를 추가하고, `NSLayoutConstraints`를 잡았는데, 오류 메시지가 났다.
  - 알고 보니 `photoImageView.translatesAutoresizingMaskIntoConstraints = false` 를 하지 않아서 난 오류 로그였다.

