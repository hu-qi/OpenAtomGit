@Component
export struct RepositorySummarySection {
  fullName: string = '';
  description: string = '';
  stars: number = 0;
  forks: number = 0;
  watchers: number = 0;
  defaultBranch: string = '';
  isLoading: boolean = false;
  errorMessage: string = '';

  build() {
    Column() {
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

      Text(this.fullName.length === 0 ? 'No repository selected' : this.fullName)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text(this.description.length > 0 ? this.description : 'No description')
        .fontSize(15)
        .lineHeight(24)
        .margin({ top: 12 })

      Row() {
        this.MetricItem('Stars', this.stars)
        this.MetricItem('Forks', this.forks)
        this.MetricItem('Watchers', this.watchers)
      }
      .width('100%')
      .margin({ top: 20 })

      Text(this.defaultBranch.length === 0 ? 'Default branch: -' : 'Default branch: ' + this.defaultBranch)
        .fontSize(14)
        .margin({ top: 16 })
    }
    .width('100%')
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
