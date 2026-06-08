import { AppRoute } from '../../navigation/AppRoute';

@Component
export struct MainPage {
  onNavigate: (route: string) => void = () => {};

  build() {
    Column() {
      Text('Main')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      Text('OpenAtomGit overview')
        .fontSize(16)
        .margin({ top: 16 })

      Button('Open repository')
        .width('90%')
        .height(48)
        .margin({ top: 24 })
        .onClick(() => {
          this.onNavigate(AppRoute.REPOSITORY_DETAIL)
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
