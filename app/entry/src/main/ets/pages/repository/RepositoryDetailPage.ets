import { AppRoute } from '../../navigation/AppRoute';
import { RepositoryModel } from '../../model/RepositoryModel';
import { RepositoryStore } from '../../store/RepositoryStore';

@Component
export struct RepositoryDetailPage {
  onNavigate: (route: string) => void = () => {};
  private repository: RepositoryModel | null = RepositoryStore.getSelectedRepository();

  build() {
    Column() {
      Text('Back')
        .fontSize(18)
        .onClick(() => {
          this.onNavigate(AppRoute.SEARCH)
        })

      Text('Repository Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 24 })

      Text(this.repository === null ? 'No repository selected' : this.repository.getFullName())
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text(this.repository === null ? '' : this.repository.description)
        .fontSize(15)
        .lineHeight(24)
        .margin({ top: 12 })

      Text('README、文件树、Issue 入口将在后续版本接入。')
        .fontSize(14)
        .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
