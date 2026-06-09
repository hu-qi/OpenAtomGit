@Component
export struct RepositoryIssueReplyNotice {
  build() {
    Text('Issue comments reply 将在后续版本接入。')
      .fontSize(14)
      .margin({ top: 24, bottom: 24 })
  }
}
