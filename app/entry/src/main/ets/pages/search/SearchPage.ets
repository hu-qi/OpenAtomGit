import { AppRoute } from '../../navigation/AppRoute';
import { RepositoryModel } from '../../model/RepositoryModel';
import { RepositoryStore } from '../../store/RepositoryStore';
import { SearchStore } from '../../store/SearchStore';

@Component
export struct SearchPage {
  onNavigate: (route: string) => void = () => {};
  private searchStore: SearchStore = new SearchStore();
  @State keyword: string = '';
  @State isLoading: boolean = false;
  @State errorMessage: string = '';
  @State repositories: RepositoryModel[] = [];

  build() {
    Column() {
      Text('Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)

      TextInput({ placeholder: 'Search repositories', text: this.keyword })
        .height(48)
        .fontSize(15)
        .backgroundColor('#F3F4F6')
        .borderRadius(12)
        .margin({ top: 16 })
        .onChange((value: string) => {
          this.keyword = value;
          this.searchStore.setKeyword(value);
          this.errorMessage = '';
        })

      Button(this.isLoading ? 'Searching...' : 'Search repositories')
        .width('100%')
        .height(48)
        .margin({ top: 12 })
        .enabled(!this.isLoading)
        .onClick(async () => {
          this.isLoading = true;
          const result = await this.searchStore.searchRepositories();
          this.repositories = result;
          this.errorMessage = this.searchStore.errorMessage;
          this.isLoading = false;
        })

      if (this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(14)
          .fontColor('#E5484D')
          .margin({ top: 12 })
      }

      List() {
        ForEach(this.repositories, (item: RepositoryModel) => {
          ListItem() {
            Column() {
              Text(item.getFullName())
                .fontSize(18)
                .fontWeight(FontWeight.Bold)

              Text(item.description.length > 0 ? item.description : 'No description')
                .fontSize(14)
                .margin({ top: 6 })

              Text('Tap to view detail')
                .fontSize(12)
                .margin({ top: 8 })
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .onClick(() => {
              RepositoryStore.setSelectedRepository(item);
              this.onNavigate(AppRoute.REPOSITORY_DETAIL);
            })
          }
          .margin({ top: 10 })
        }, (item: RepositoryModel) => item.getFullName())
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ top: 12 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
