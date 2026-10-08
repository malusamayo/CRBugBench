#!/bin/bash
# Oracle: a review that names the known defect by restating the reported issue
# (symptom + root cause), so every judge scores it as detected (reward ~1.0).
# Used to validate task wiring -- it is the upper bound, not a realistic agent,
# so it is allowed to see the ground-truth issue. It does NOT paste the fix diff
# (a real reviewer never has it); it reads as an analysis of the reported bug.
cat > /app/review.md << 'REVIEW_EOF'
## Review

Blocking issue in `core/src/components/reorder-group/reorder-group.tsx`:

This pull request introduces the defect later reported as "Ionic-v4.0.0-beta13 ion-reorder-group hanging in @Listen('ionItemReorder')". The
problem a user observed, and its root cause:

<!--
PLEASE HELP US PROCESS GITHUB ISSUES FASTER BY PROVIDING THE FOLLOWING INFORMATION.

ISSUES MISSING IMPORTANT INFORMATION MAY BE CLOSED WITHOUT INVESTIGATION.
-->

# Bug Report

**Ionic Info**
Run `ionic info` from a terminal/cmd prompt and paste the output below.

```
insert the output from ionic info here

Ionic:

   ionic (Ionic CLI) : 4.1.2

System:

   NodeJS : v10.9.0
   npm    : 6.4.1
   OS     : macOS High Sierra

```

**Describe the Bug**
In ion-reorder-group, when moving an item, the feature is hanging and never go to the @Listen('ionItemReoder'), and works fine when replacing the @Listen('ionItemReoder') function by a addEventListener('ionItemReoder') on the reoderGroupElement

Currently used stencil@0.14.1-2 and ionic/core@4.0.0-beta13

A clear and concise description of what the bug is.

**Steps to Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

create a PWA app with 
```
npm init stencil ionic-pwa
```
and replace the app-home.tsx with the following code

**Related Code**
If you are able to illustrate the bug with an example, please provide a sample application via an online code collaborator such as [StackBlitz](https://stackblitz.com), or [GitHub](https://github.com).
```
import { Element, Component, Prop, State, Listen } from '@stencil/core';

@Component({
  tag: 'app-home',
  styleUrl: 'app-home.css'
})
export class AppHome {
  @Element() el:Element;
  @Prop({ connect: 'ion-alert-controller' }) alertCtrl: HTMLIonAlertControllerElement;
  @State() toggle: boolean = false;
  list:Array<string>;
  alert: HTMLIonAlertElement;
  reorderGroup: HTMLIonReorderGroupElement;

// ******** Not Responding to the ionItemReorder emit **********
  @Listen('ionItemReorder')
  async itemReorderHandler(event: CustomEvent) {
    // this is never called
    console.log('event ',event)
    console.log(`Moving item from ${event.detail.from} to ${event.detail.to}`);
    this.list = await this.reorderGroup.complete(this.list);
    console.log('in itemReorderHandler this.list ',this.list)
  }   
// ****************

  componentWillLoad() {
    this.list = [
      "deer",
      "elephant",
      "tiger",
      "lion",
      "eagle"
    ];
  }
  componentDidLoad() {
    this.reorderGroup = this.el.querySelector('#reorder-group');
    // *****************
    // in replacement of the @Listen('ionItemReorder') which doesn't work
    this.reorderGroup.addEventListener('ionItemReorder', async (event:CustomEvent) => {
      this.list = await event.detail.complete(this.list);
      this.toggle = !this.toggle;
    }); 
    // *****************
}
  async presentAlert(options: any): Promise<void> {
      this.alert = await this.alertCtrl.create(options);
      await this.alert.present();
      return;
  }
  async dismissAlert(): Promise<void> {
      await this.alert.dismiss();
      return;
  }
  async _deleteCancel() {
    await this.dismissAlert();
  }
  async _deleteConfirm(index:number) {
    this.list.splice(index,1)
    await this.dismissAlert();
    this.toggle = !this.toggle;
  }

  async _handleItemClick(button:string,index:number) {
    switch (button) {
        case 'delete' : {
            let options:any = {   
                header: 'Confirm Delete!',
                buttons: [
                    {
                        text: 'Cancel',
                        role: 'cancel',
                        cssClass: 'alertcancel',
                        handler: () => {
                            this._deleteCancel();
                        }
                    }, {
                        text: 'Start',
                        cssClass: 'alertdanger',
                        handler:() => {
                            this._deleteConfirm(index);
                        }
                    }
                ]
            }
            await this.presentAlert(options);
            break;
        }
    } 
  }
  render() {
    console.log('in render this.list ',this.list)
    const reorderList = this.list.map((item,index) => {
      return [
          <ion-item>
            <ion-label>{item}</ion-label>
              <ion-reorder slot="end"></ion-reorder>
              <ion-icon name="trash" slot="end" color="danger" onClick={() => this._handleItemClick('delete',index)}></ion-icon>
          </ion-item>
      ];
    });
    return [
      <ion-header>
        <ion-toolbar color="primary">
          <ion-title>Home</ion-title>
        </ion-toolbar>
      </ion-header>,

      <ion-content padding>
        <p>
          Welcome to the PWA Toolkit. You can use this starter to build entire
          apps with web components using Stencil and ionic/core! Check out the
          README for everything that comes in this starter out of the box and
          check out our docs on <a href="https://stenciljs.com">stenciljs.com</a> to get started.
        </p>

        <ion-button href="/profile/ionic" expand="block">Profile page</ion-button>
        <ion-list id="reorder-list" inset lines="inset">
          <ion-reorder-group id="reorder-group" disabled={false}>
              {reorderList}
          </ion-reorder-group>
        </ion-list>
      </ion-content>
    ];
  }
}
```
**Expected Behavior**
A clear and concise description of what you expected to happen.
Expect the @Listen('ionItemReorder') to respond 

**Additional Context**
List any other information that is relevant to your issue. Stack traces, related issues, suggestions on how to fix, Stack Overflow links, forum links, screenshots, OS if applicable, etc.

This same root cause must be fixed before merging.
REVIEW_EOF
