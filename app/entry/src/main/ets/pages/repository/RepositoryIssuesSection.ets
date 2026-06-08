import { IssueCommentModel } from '../../model/IssueCommentModel';
import { IssueModel } from '../../model/IssueModel';

@Component
export struct RepositoryIssuesSection {
  issues: IssueModel[] = [];
  selectedIssue: IssueModel | null = null;
  issueComments: IssueCommentModel[] = [];
  isIssuesLoading: boolean = false;
  isIssueDetailLoading: boolean = false;
  isIssueCommentsLoading: boolean = false;
  issuesMessage: string = '';
  issueDetailMessage: string = '';
  issueCommentsMessage: string = '';
  onOpenIssue: (issue: IssueModel) => void = () => {};

  build() {
    Column() {
      Text('Issues')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 28 })

      if (this.isIssuesLoading) {
        Text('Loading issues...')
          .fontSize(15)
          .margin({ top: 12 })
      }

      if (this.issuesMessage.length > 0) {
        Text(this.issuesMessage)
          .fontSize(14)
          .fontColor('#6B7280')
          .margin({ top: 12 })
      }

      ForEach(this.issues, (item: IssueModel) => {
        Column() {
          Text('#' + item.number.toString() + ' ' + item.title)
            .fontSize(15)
            .fontWeight(FontWeight.Bold)
          Text(item.state + (item.author.length > 0 ? ' · ' + item.author : '') + ' · Tap to view detail')
            .fontSize(12)
            .margin({ top: 6 })
        }
        .width('100%')
        .padding(12)
        .margin({ top: 8 })
        .backgroundColor(Color.White)
        .borderRadius(12)
        .onClick(() => {
          this.onOpenIssue(item);
        })
      }, (item: IssueModel) => item.number.toString())

      if (this.selectedIssue !== null) {
        Text('Issue Detail')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 28 })

        if (this.isIssueDetailLoading) {
          Text('Loading issue detail...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.issueDetailMessage.length > 0) {
          Text(this.issueDetailMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        Text('#' + this.selectedIssue.number.toString() + ' ' + this.selectedIssue.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 12 })

        Text(this.selectedIssue.state + ' · comments ' + this.selectedIssue.comments.toString())
          .fontSize(13)
          .margin({ top: 8 })

        Text(this.selectedIssue.updatedAt.length > 0 ? 'Updated: ' + this.selectedIssue.updatedAt : '')
          .fontSize(12)
          .margin({ top: 6 })

        Text(this.selectedIssue.body.length > 0 ? this.selectedIssue.body : 'No issue body')
          .fontSize(13)
          .lineHeight(20)
          .padding(12)
          .margin({ top: 12 })
          .backgroundColor(Color.White)
          .borderRadius(12)

        Text('Comments')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20 })

        if (this.isIssueCommentsLoading) {
          Text('Loading issue comments...')
            .fontSize(15)
            .margin({ top: 12 })
        }

        if (this.issueCommentsMessage.length > 0) {
          Text(this.issueCommentsMessage)
            .fontSize(14)
            .fontColor('#6B7280')
            .margin({ top: 12 })
        }

        ForEach(this.issueComments, (item: IssueCommentModel) => {
          Column() {
            Text(item.author.length > 0 ? item.author : 'Unknown')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
            Text(item.updatedAt.length > 0 ? 'Updated: ' + item.updatedAt : '')
              .fontSize(12)
              .margin({ top: 4 })
            Text(item.body.length > 0 ? item.body : 'No comment body')
              .fontSize(13)
              .lineHeight(20)
              .margin({ top: 8 })
          }
          .width('100%')
          .padding(12)
          .margin({ top: 8 })
          .backgroundColor(Color.White)
          .borderRadius(12)
        }, (item: IssueCommentModel) => item.id.toString())
      }
    }
    .width('100%')
  }
}
