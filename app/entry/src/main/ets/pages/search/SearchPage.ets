@Component
export struct SearchPage {
  build() {
    Column() {
      Text('Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
      TextInput({ placeholder: 'Keyword' })
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}
