Contributing to Inheritance Module Eval
==========================
Inheritance Module Eval is an open source project. Anyone can use the code, but more importantly, anyone can contribute. This is a
 group effort and we value your input. Please consider making a contribution to help improve the Inheritance Module Eval. This
 guide covers:

* How to file a ticket when you discover a bug
* How to contribute fixes and improvements to the core
* Information on how to improve the documentation

1. Who can Contribute?
----------------------
Inheritance Module Eval is an open source project and as such contributions are always welcome. Our community is one which
 encourages involvement from all developers regardless of their ability level. We ask that you be patient with the
 other members of the community and maintain a respectful attitude towards other people’s work. Open source is a
 great way to learn a new technology so don’t be afraid to jump right in, even if you are new to Ruby/Rails.

2. Before you Contribute
------------------------
Open source projects tend to be a collaborative effort. Since many people are relying upon Inheritance Module Eval for their real
 world applications, changes to the code can have major implications. Before you write a bug fix or code a new
 feature, you should find out if anybody is interested in your proposed change. You may find that the thing you’re
 trying to “fix” is actually desired behavior. You might also discover that someone else is working on it. Either
 way you can save yourself valuable time by announcing your intentions before starting work.

### 2.1. Notification via Ticket

You can also search existing bug reports/issues and file a new one if you do not find an issue relevant to your
 proposed change. See Filing an Issue for more details.

The important thing is that you communicate your intention in advance of doing a lot of work. Simple bug fixes and
 non-controversial changes do not require this approach but you can save some time by suggesting an improvement and
 having it rejected before you write a bunch of the code.

3. Filing an Issue
-----------------
If you would like to file a bug report, please create an issue in our Github Issues Tracker. You should do a basic
 search of the issues database before creating a new issue to ensure that you are not creating a duplicate issue.

Please do not assign labels or create new labels to your issue. We will assign the appropriate labels to ensure your
 ticket is handled in the appropriate manner.

### 3.1. Providing a Patch

If you are filing and issue and supplying a patch at the same time, please file a Pull Request instead. The pull
 request will also create an issue at the same time but its superior to just creating an issue because the code and
 issue can be linked.

If the ticket already exists, however, and you want to supply a patch after the fact,
 you can simply reference the issue number in your commit message. For example, if your commit fixed issue #123 you
 could use the following commit message:

    Fixed a problem with Facebook authentication.

    [Fixes #123]
Github will automatically detect this commit message when you push it and link the issue. Please see the detailed
 Github Issues blog post for more details.

### 3.2. Feature Requests

We’re interested in hearing your ideas for new features but creating feature requests in the Issue Tracker is not
 the proper way to ask for a feature. A feature request is any idea you have to improve the software experience that
 is not strictly related to a bug or error of omission.

Feature requests that are accompanied by source code are always welcome. In this case you should read the next
 section on Creating a Pull Request.

Feature requests without accompanying code will be closed. We simply cannot respond efficiently to feature requests
 through our Issue Tracker. If you want to suggest a feature, please use the mailing list or the user voice forum.

### 3.3. How We Prioritize Issues

We try our best to respond to all of the questions and issues our users have. We use the following criteria to
prioritize issues:

* Does this bug effect the latest stable release?
* Is there a patch associated with the issue?
* Is ther a test included in the patch?
* Has someone else verified the bug?
* Are there details on how to reproduce the problem?
* We give highest priority to issues where the answer is “yes” to all of these questions. Next highest priority is for
 issues that answer “yes” to most of these questions, particularly the first few criteria.

You need to include a brief description of the problem and simple steps needed to reproduce it. If you fail to
 supply this minimum level of information your issue will likely be ignored.


4. Creating a Pull Request
--------------------------

If you are going to contribute code to the Inheritance Module Eval project, the best mechanism for doing this is to create a pull
 request in Github. If you’re unfamiliar with the general concept of pull requests you may want to read more on pull
 requests in Github.

If your code is associated with an existing issue then you can provide a patch instead of creating a pull request.

### 4.1. Creating a Fork

The official Inheritance Module Eval source code is maintained in Github under the AlexParamonov/inheritance_module_eval

You simply need to “fork” the project and then start hacking.

See the Github guide on creating forks for more details.

### 4.2. Topic Branches

Git branches are “cheap.” Creating branches in Git is incredibly easy and its an ideal way to isolate a specific set
 of changes. You may be fixing several things at one time but by keeping your changes isolated it will help us to
 find and apply only the changes we’re interested in. You should create a clean branch based on the latest
 inheritance_module_eval/master when doing this. It is important you follow these steps exactly,
 it will prevent you from accidentally including unrelated changes from your local repository into the branch.

For example, if we were submitting a patch to fix an issue with the CSS in the flash error message you could create
 a branch as follows:

    $ git remote add upstream git://github.com/AlexParamonov/inheritance_module_eval.git
    $ git fetch upstream
    $ git checkout -b fix-css-for-error-flash --track upstream/master

The fetch command will grab all of the latest commits from the Inheritance Module Eval master branch. Don’t worry,
 it doesn’t alter your working repository in a harmful way. The track part of the command will tell git that this
 branch should track with the remote version of the upstream master. This is another way of saying that the branch
 should be based on a clean copy of the latest official source code (without any of your unrelated local changes.)

You can then do work locally on this topic branch and push it up to your Github fork when you are done. So in our
 previous example we do something like:

    $ git push origin fix-css-for-error-flash

Of course if you want the fix for yourself to use in your own local code you should probably merge it down to your
 own personal master branch that you’re using for development

    $ git checkout master
    $ git merge fix-css-for-error-flash

You should probably also clean up after yourself a little. The branch has been pushed to Github and you’ve merged it
  locally so you don’t really need a local copy of the branch laying around.

    $ git branch -D fix-css-for-error-flash

### 4.3. Including a Test

Ideally your pull request will also include a test that verifies a bug (or the absence of the new feature) before
 your fix and also verifies proper functionality when you are finished. Please read the Testing Guide for more
 information on writing and running your tests.

Pull requests with tests are given top priority. Failure to include a test will likely delay acceptance of your patch.

### 4.4. Creating the Pull Request

Once your code is ready to go and you have pushed your topic branch to Github then you are ready to create the pull
 request and notify the Inheritance Module Eval team that your contribution is ready. You do this by browsing your project in
 Github and changing to the topic branch you just pushed. Once you are on the topic branch simply create a pull
 request by pressing the “Pull Request” button.

The Github guide on pull requests describes this in more detail with screenshots if you’re still confused on this
 part.

5 Contributing to the Documentation
-----------------------------------
Improvements to the documentation is encouraged.