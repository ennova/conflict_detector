# Conflict Detector

ConflictDetector is a convenience class for saving the record, or returning the conflict.

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'conflict_detector'
```

## Usage

``` ruby
def create
  @post = Post.build(params[:post])
  detector = ConflictDetector.new(@post, :title, :content, :user_id)
  @post = detector.conflicting_or_created_record
  respond_with @post, :status => detector.status
end
```
