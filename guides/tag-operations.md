---
layout: doc
sublayout: guide
title: Working with tags
reviewed: 2017-04-28T10:27:42-04:00
---

## Viewing and modifying tags

The tags of a repository can be viewed and modified in the tags panel of the repository page, found by clicking on the <span class="tab-reference"><i class="fa fa-tags tab-icon"></i>Tags</span> tab.

<center>
    <a href="tag-operations.png"><img src="tag-operations.png" style="width:80%;"></a>
</center>

### Adding a new tag to a tagged image

A new tag can be added to a tagged image by clicking on the <span class="tab-reference"><i class="fa fa-gear"></i></span> icon next to the tag and choosing <span class="tab-reference"><i class="fa fa-plus"></i> Add New Tag</span>. Quay.io will confirm the addition of the new tag to the image.

### Moving a tag

Moving a tag to a different image is accomplished by performing the same operation as adding a new tag, but giving an existing tag name. Quay.io will confirm that you want the tag moved, rather than added.

### Deleting a tag

A specific tag and all its images can be deleted by clicking on the <span class="tab-reference"><i class="fa fa-gear"></i></span> icon and choosing <span class="tab-reference"><i class="fa fa-times"></i> Delete Tag</span>. This will delete the tag and any images unique to it. Images will not be deleted until no tag references them either directly or indirectly through a parent child relationship.

### Viewing tag history and going back in time

#### Viewing tag history

To view the image history for a tag, click on the <span class="tab-reference"><i class="fa fa-history"></i> View Tags History</span> menu item located under the <span class="tab-reference"><i class="fa fa-cog"></i> Actions</span> menu. The page shown will display each image to which the tag pointed in the past and when it pointed to that image.

#### Going back in time

To revert the tag to a previous image, find the history line where your desired image was overwritten, and click on the Restore link.

### Security scanning

By clicking the on the vulnerability or fixable count next to a tab you can jump into the security scanning information for that tag. There you can find which CVEs your image is susceptible to, and what remediation options you may have available.
