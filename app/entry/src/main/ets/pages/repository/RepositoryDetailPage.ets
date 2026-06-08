import { AppRoute } from '../../navigation/AppRoute';
import { RepositoryModel } from '../../model/RepositoryModel';
import { AtomGitRepositoryService } from '../../service/AtomGitRepositoryService';
import { RepositoryStore } from '../../store/RepositoryStore';

@Component
export struct RepositoryDetailPage {
  onNavigate: (route: string) => void = () => {};
  @State isLoading: boolean = false;
  @State errorMessage: string = '';
  @State repository: RepositoryModel | null = RepositoryStore.getSelectedRepository();

  async aboutToAppear(): Promise<void> {
    if (this.repository === null) {
      this.errorMessage = 'No repository selected';
      return;
    }

    this.isLoading = true;
    const detail = await AtomGitRepositoryService.getRepositoryDetail(this.repository);
    this.isLoading = false;

    if (detail === null) {
      this.errorMessage = 'Repository detail load failed';
      return;
    }

    this.repository = detail;
    RepositoryStore.setSelectedRepository(detail);
    this.errorMessage = '';
  }

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

      if (this.isLoading) {
        Text('Loading repository detail...')
          .fontSize(15)
          .margin({ top: 16 })
      }

      if (this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#E5484D')
          .margin({ top: 12 })
      }

      Text(this.repository === null ? 'No repository selected' : this.repository.getFullName())
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text(this.repository === null ? '' : (this.repository.description.length > 0 ? this.repository.description : 'No description'))
        .fontSize(15)
        .lineHeight(24)
        .margin({ top: 12 })

      Row() {
        this.MetricItem('Stars', this.repository === null ? 0 : this.repository.stars)
        this.MetricItem('Forks', this.repository === null ? 0 : this.repository.forks)
        this.MetricItem('Watchers', this.repository === null ? 0 : this.repository.watchers)
      }
      .width('100%')
      .margin({ top: 20 })

      Text(this.repository === null || this.repository.defaultBranch.length === 0 ? 'Default branch: -' : 'Default branch: ' + this.repository.defaultBranch)
        .fontSize(14)
        .margin({ top: 16 })

      Text('README、文件树、Issue 入口将在后续版本接入。')
        .fontSize(14)
        .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

  @Builder
  MetricItem(label: string, value: number) {
    Column() {
      Text(value.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(12)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
