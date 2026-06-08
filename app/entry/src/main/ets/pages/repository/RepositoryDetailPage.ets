import { AppRoute } from '../../navigation/AppRoute';

@Component
export struct RepositoryDetailPage {
  onNavigate: (route: string) => void = () => {};

  build() {
    Column() {
      Text('Back')
        .fontSize(18)
        .onClick(() => {
          this.onNavigate(AppRoute.HOME)
        })

      Text('Repository Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 24 })

      Text('hu-qi/OpenAtomGit')
        .fontSize(18)
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
