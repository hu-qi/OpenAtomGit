@Component
export struct RepositoryReadmeSection {
  isReadmeLoading: boolean = false;
  readmeMessage: string = '';
  readmeContent: string = '';

  build() {
    Column() {
      Text('README')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 28 })

      if (this.isReadmeLoading) {
        Text('Loading README...')
          .fontSize(15)
          .margin({ top: 12 })
      }

      if (this.readmeMessage.length > 0) {
        Text(this.readmeMessage)
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ top: 12 })
      }

      if (this.readmeContent.length > 0) {
        Text(this.readmeContent)
          .fontSize(13)
          .lineHeight(20)
          .padding(12)
          .margin({ top: 12 })
          .backgroundColor(Color.White)
          .borderRadius(12)
      }
    }
    .width('100%')
  }
}
